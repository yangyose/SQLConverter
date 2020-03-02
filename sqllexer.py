import re
from sqltoken import SQLToken
from sqlrules import ORACLE_RULES, ORACLE_KEYWORDS, POSTGRESQL_RULES, POSTGRESQL_KEYWORDS, MYSQL_RULES, MYSQL_KEYWORDS

class SQLLexer(object):
    __rules_pattern     = {'oracle':ORACLE_RULES,
                           'postgresql':POSTGRESQL_RULES,
                           'mysql':MYSQL_RULES}
    __keywords_pattern  = {'oracle':ORACLE_KEYWORDS,
                           'postgresql':POSTGRESQL_KEYWORDS,
                           'mysql':MYSQL_KEYWORDS}
    __match_flag        = re.I

    def __init__(self, sql_engine = 'oracle', sql_str = ''):
        self.__engine = sql_engine
        self.__stream = sql_str

    @property
    def engine(self):
        return self.__engine
    @engine.setter
    def engine(self, value):
        self.__engine = value
    @property
    def stream(self):
        return self.__stream
    @stream.setter
    def stream(self, value):
        self.__stream = value

    def scan(self):
        sql_str = self.__stream
        other_str = ''
        tokens  = []
        while sql_str:
            sql_str, other_str, tokens = self.__get_next_token(sql_str, other_str, tokens)
        if other_str:
            token = SQLToken('other', other_str)
            tokens.append(token)
            other_str = ''
        return tokens

    def __get_next_token(self, sql_str, other_str, tokens):
        rules       = self.__rules_pattern[self.__engine]
        keywords    = self.__keywords_pattern[self.__engine]
        is_matched  = False
        for rule in rules:
            matchs = re.match(rule[0], sql_str, self.__match_flag)
            if matchs:
                is_matched = True
                if other_str:
                    token = SQLToken('other', other_str)
                    tokens.append(token)
                    other_str = ''
                t_type = rule[1]
                if t_type == 'identifier' and matchs.group(1).upper() in keywords:
                    t_type = 'keyword' 
                token   = SQLToken(t_type, matchs.group(1))
                tokens.append(token)
                sql_str = sql_str[len(matchs.group(1)):]
                break
        if not is_matched:
            other_str = other_str + sql_str[0]
            sql_str = sql_str[1:]
        return sql_str, other_str, tokens

