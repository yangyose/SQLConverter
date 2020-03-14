import re
from sqltoken import SQLToken
from sqlrules import ORACLE_SCAN_RULES, ORACLE_KEYWORDS, POSTGRE_SCAN_RULES, POSTGRE_KEYWORDS, MYSQL_SCAN_RULES, MYSQL_KEYWORDS

class SQLLexer(object):
    __rules_pattern     = {'oracle':ORACLE_SCAN_RULES,
                           'postgresql':POSTGRE_SCAN_RULES,
                           'mysql':MYSQL_SCAN_RULES}
    __keywords_pattern  = {'oracle':ORACLE_KEYWORDS,
                           'postgresql':POSTGRE_KEYWORDS,
                           'mysql':MYSQL_KEYWORDS}

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
            token = SQLToken('Other', other_str)
            tokens.append(token)
            other_str = ''
        return tokens

    def __get_next_token(self, sql_str, other_str, tokens):
        rules       = self.__rules_pattern[self.__engine]
        keywords    = self.__keywords_pattern[self.__engine]
        is_matched  = False
        for rematch, t_type in rules:
            matchs = rematch(sql_str)
            if matchs:
                is_matched = True
                if other_str:
                    token = SQLToken('Other', other_str)
                    tokens.append(token)
                    other_str = ''
                if t_type == 'Identifier' and matchs.group(1).upper() in keywords:
                    t_type = 'Keyword' 
                token   = SQLToken(t_type, matchs.group(1))
                tokens.append(token)
                sql_str = sql_str[len(matchs.group(1)):]
                break
        if not is_matched:
            other_str = other_str + sql_str[0]
            sql_str = sql_str[1:]
        return sql_str, other_str, tokens

