_hexdig = '0123456789ABCDEFabcdef'
_hextochr = dict((a + b, chr(int(a + b, 16)))
                 for a in _hexdig for b in _hexdig)

cdef str unquote(str s):
    """unquote('abc%20def') -> 'abc def'."""
    res = s.split('%')
    # fastpath
    if len(res) == 1:
        return s                                                                
    s = res[0]                                                                  
    for item in res[1:]:                                                        
        try:                                                                    
            s += _hextochr[item[:2]] + item[2:]                                 
        except KeyError:                                                        
            s += '%' + item                                                     
        except UnicodeDecodeError:                                              
            s += unichr(int(item[:2], 16)) + item[2:]                           
    return s

import string
_processLinetable = string.maketrans('-','_')

cdef tuple _processLine(str line):
    newline = line.translate(None, '\r\n')
    k, v = newline.split(":", 1)
    k = k.translate(_processLinetable)
    k = k.strip()
    v = unquote(v.strip())
    return (k, v)

def processLine(str line):
    return _processLine(line)
