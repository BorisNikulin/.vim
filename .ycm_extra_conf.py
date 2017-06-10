def FlagsForFile( filename, **kwargs ):
  return {
    'flags': [ '-x', 'c++', '-std=c++14',  '-Wall', '-Wextra', '-Werror' ],
  }

