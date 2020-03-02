
class SQLToken(object):

    def __init__(self, token_type = None, token_name = None):
        self.__ttype = token_type
        self.__tname = token_name

    @property
    def ttype(self):
        return self.__ttype
    @ttype.setter
    def ttype(self, value):
        self.__ttype = value

    @property
    def tname(self):
        return self.__tname
    @tname.setter
    def tname(self, value):
        self.__tname = value
    
