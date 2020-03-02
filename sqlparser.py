
class SQLParser(object):

    def _init_(self, sql_engine = 'oracle', sql_tokens = []):
        self.__engine = sql_engine
        self.__tokens = sql_tokens

    @property
    def engine(self):
        return self.__engine
    @engine.setter
    def engine(self, value):
        self.__engine = value
    @property
    def tokens(self):
        return self.__tokens
    @stream.setter
    def tokens(self, value):
        self.__tokens = value

    def parse(self):
        return None
        
