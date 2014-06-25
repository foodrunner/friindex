IIndex = require('../src/friindex')

describe 'friindex', ->
  describe 'union', ->

    it '2 sets', (done) ->
      h1 = {$: 2, ids: {'1m': true, '2m': true}}
      h2 = {$: 3, ids: {'1m': true, '3m': true, '5m': true}}
      h = IIndex.union([h1, h2])
      expect(h.$).toBe(4)
      expect(h.ids['1m']).toBe(true)
      expect(h.ids['2m']).toBe(true)
      expect(h.ids['3m']).toBe(true)
      expect(h.ids['5m']).toBe(true)
      done()
