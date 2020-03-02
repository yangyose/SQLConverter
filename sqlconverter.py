from sqllexer  import SQLLexer
from sqlparser import SQLParser

class SQLConverter(object):

    def __init__(self, sql_engine_from = 'oracle', sql_engine_to = 'postgresql', sql_str = ''):
        self.__engine_from = sql_engine_from
        self.__engine_to = sql_engine_to
        self.__stream = sql_str

    @property
    def engine_from(self):
        return self.__engine_from
    @ttype.setter
    def engine_from(self, value):
        self.__engine_from = value

    @property
    def engine_to(self):
        return self.__engine_to
    @ttype.setter
    def engine_to(self, value):
        self.__engine_to = value

    @property
    def stream(self):
        return self.__stream
    @tname.setter
    def stream(self, value):
        self.__stream = value

    def convert(self):
        sql_lexer = SQLLexer(self.__engine_from, self.__stream)
        sql_tokens = sql_lexer.scan()
        sql_parser = SQLParser(self.__engine_from, sql_tokens)
        sql_ast = sql_parser.parse()
        sql_str = self.__generate(self.__engine_to, sql_ast)
        return sql_str

    def __generate(self, engine, ast):
        return ''
        
