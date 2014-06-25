IIndex = require('../src/friindex')

describe 'friindex', ->
  describe 'intersect', ->

    it '2 sets without common ids', ->
      h1 = {$: 2, ids: {'1m': true, '2m': true}}
      h2 = {$: 3, ids: {'3m': true, '4m': true, '5m': true}}
      h = IIndex.intersect([h1, h2])
      expect(h.$).toBe(0)
      expect(h.ids).toEqual({})

    it '2 sets with some common ids', ->
      h1 = {$: 2, ids: {'1m': true, '2m': true}}
      h2 = {$: 3, ids: {'1m': true, '3m': true, '5m': true}}
      h = IIndex.intersect([h1, h2])
      expect(h.$).toBe(1)
      expect(h.ids['1m']).toBe(true)
