
class SQLParser(object):

    def __init__(self, sql_engine = 'oracle', sql_tokens = []):
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
    @tokens.setter
    def tokens(self, value):
        self.__tokens = value

    def parse(self):
    	vt_indexes = self.__pre_process()
    	
    	return vt_indexes

    def __pre_process(self):
    	return [i for i, element in enumerate(self.__tokens) if element.ttype not in ('Comment', 'Prompt', 'Whitespace')]
        
