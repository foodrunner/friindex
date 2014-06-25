natural = require('natural')

normalization_pattern = new RegExp('[^a-zA-Z ]', 'g')
spaces = new RegExp(' +', 'g')
empty = []
blacklist = {"the": true, "be": true, "to": true, "of": true, "and": true, "in": true, "that": true, "have": true, "it": true, "not": true, "on": true, "with": true, "he": true, "as": true, "you": true, "do": true, "at": true, "this": true, "but": true, "his": true, "by": true, "from": true, "for": true, "are": true, "serve": true, "dish": true, "dishes": true, "restaurant": true, "restaurants": true, "its": true, "your": true, "all": true, "an": true, "is": true, "food": true, "serv": true, "cuisine": true}

class FrIIndex
  constructor: () -> @map = {}

  add: (id, text) ->
    tokens = FrIIndex.normalize(text).split(' ')
    @index(id, word) for word in tokens

  lookup: (text) ->
    tokens = FrIIndex.normalize(text).split(' ')
    result = FrIIndex.intersect(FrIIndex.union(@map[v] for v in FrIIndex.variants(token) when @map[v]?) for token in tokens)
    Object.keys(result.ids)

  index: (id, word) ->
    return if blacklist[word]?
    for w in FrIIndex.variants(word)
      @map[w] = {$: 0, ids: {}} unless @map[w]?
      @map[w].ids[id] = true
      @map[w].$++

  @normalize: (text) ->
    text.replace(normalization_pattern, '').replace(spaces, ' ').trim().toLowerCase()

  @variants: (word) ->
    arr = [word]
    stemmed = natural.PorterStemmer.stem(word)
    arr.push(stemmed) if stemmed isnt word
    arr

  @union: (hashes) ->
    result = {$: 0, ids: {}}
    for hash in hashes
      for id of hash.ids when !result.ids[id]
        result.ids[id] = true
        result.$++
    result

  @intersect: (hashes) ->
    length = hashes.length
    range = [1...length]
    hashes.sort((h1, h2) -> h1.$ - h2.$)
    result = {$: 0, ids: {}}
    for id, _ of hashes[0].ids
      found = true
      for i in range
        unless hashes[i].ids[id]?
          found = false
          break
      if found
        result.$++
        result.ids[id] = true
    result

module.exports = FrIIndex
