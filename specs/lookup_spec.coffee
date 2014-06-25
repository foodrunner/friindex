IIndex = require('../src/friindex')

describe 'friindex', ->
  describe 'lookup', ->

    it 'union variants of a token', ->
      dict = new IIndex()
      dict.map['a'] = {$:1, ids:{'1m': true}}
      dict.map['b'] = {$:1, ids:{'2m': true}}
      spyOn(IIndex, 'variants').andReturn(['a', 'b'])
      ids = dict.lookup('a')
      expect(ids.length).toBe(2)
      expect(ids).toEqual(['1m', '2m'])

    it 'intersect tokens', ->
      dict = new IIndex()
      dict.map['apple'] = {$:2, ids:{'1m': true, '2m': true}}
      dict.map['juice'] = {$:3, ids:{'2m': true, '3m': true, '4m': true}}
      ids = dict.lookup('apple juice')
      expect(ids.length).toBe(1)
      expect(ids).toEqual(['2m'])