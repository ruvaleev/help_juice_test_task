const { expect } = require('@jest/globals')

import actualQuery from '../../app/javascript/functions/actualQuery'

describe('actualQuery', () => {
  describe('when queryVariations are blank, undefined or not provided', () => {
    const query = 'query'

    it('returnn false if queryVariations are blank', () => {
      expect(actualQuery(query, [])).toEqual(query)
    })

    it('returnn false if queryVariations undefined', () => {
      expect(actualQuery(query, undefined)).toEqual(query)
    })

    it('returnn false if queryVariations is not provided', () => {
      expect(actualQuery(query)).toEqual(query)
    })
  });

  describe('when queryVariations are provided', () => {
    it('returns query when last variation includes strings with different letter case', () => {
      expect(actualQuery('What', ['what'])).toEqual('What')
    })

    it('returns query when query is longer than any of provided queryVariations', () => {
      expect(actualQuery('What is', ['what'])).toEqual('What is')
    })

    it('returns longest of queryVariations when query is shorter', () => {
      expect(actualQuery('What', ['Whati', 'What is'])).toEqual('What is')
    })
  });
})
