IIndex = require('../src/friindex')

describe 'friindex', ->
  describe 'index', ->

    it 'not blacklist word', ->
      dict = new IIndex()
      dict.index('1m', 'be')
      expect(dict.map).toEqual({})

    it 'word and its variants', ->
      spyOn(IIndex, 'variants').andReturn(['word', 'words'])
      dict = new IIndex()
      dict.index('1m', 'words')
      expect(dict.map['word']).toEqual({$: 1, ids: {'1m': true}})
      expect(dict.map['words']).toEqual({$: 1, ids: {'1m': true}})

    it 'an existing word', ->
      spyOn(IIndex, 'variants').andReturn(['word'])
      dict = new IIndex()
      dict.index('1m', 'word')
      dict.index('2m', 'word')
      expect(dict.map['word'].$).toBe(2)
      expect(dict.map['word'].ids['1m']).toBe(true)
      expect(dict.map['word'].ids['2m']).toBe(true)
