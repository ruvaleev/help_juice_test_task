const { expect } = require('@jest/globals')

import isDouble from '../../app/javascript/functions/isDouble'

describe('isDouble', () => {
  describe('when lastQueryVariation is undefined or not provided', () => {
    it('returnn false if lastQueryVariation undefined', () => {
      expect(isDouble('query', undefined)).toBeFalsy()
    })

    it('returnn false if lastQueryVariation is not provided', () => {
      expect(isDouble('query')).toBeFalsy()
    })
  });

  describe('when lastQueryVariation is provided', () => {
    it('when last variation includes strings with different letter case', () => {
      expect(isDouble('What', 'what')).toBeTruthy()
    })

    it('returns true when query includes last variation', () => {
      expect(isDouble('What is', 'what')).toBeTruthy()
    })

    it('returns true when query includes last variation with missed spaces', () => {
      expect(isDouble('What is', 'whatis')).toBeTruthy()
    })

    it('returns true when query includes last variation with extra spaces', () => {
      expect(isDouble('What is', 'wh atis')).toBeTruthy()
    })

    it('returns true when query includes last variation without some letters', () => {
      expect(isDouble('What is', 'hati')).toBeTruthy()
    })

    it('returns true when last variation includes query with spaces, wrong letter case and missed letters', () => {
      expect(isDouble('haT i', 'What is')).toBeTruthy()
    })

    it("returns false when query doesn't include last variation", () => {
      expect(isDouble('What', 'How')).toBeFalsy()
    })
  });
})
