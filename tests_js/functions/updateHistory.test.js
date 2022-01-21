const { expect } = require('@jest/globals')

import updateHistory from '../../app/javascript/functions/updateHistory'

describe('updateHistory', () => {
  const currentTime = new Date();
  const query_1 = 'what is'
  const query_2 = 'What is a'
  let retreivedHistory;

  jest
    .useFakeTimers()
    .setSystemTime(currentTime);

  it('returns upadted history', () => {
    retreivedHistory = updateHistory(query_1)
    expect(retreivedHistory).toEqual([[query_1, currentTime]]);
  })

  describe('when isDouble flag is true', () => {
    it('updates last query in history with provided value', () => {
      retreivedHistory = updateHistory(query_2, [[query_1, currentTime]], true)
      expect(retreivedHistory).toEqual([[query_2, currentTime]])
    })
  })

  describe('when isDouble flag is false', () => {
    it('updates appends new query to history', () => {
      retreivedHistory = updateHistory(query_2, [[query_1, currentTime]], false)
      expect(retreivedHistory).toEqual([[query_1, currentTime], [query_2, currentTime]])
    })
  })

  describe('when query is blank', () => {
    it('returns provided history', () => {
      retreivedHistory = updateHistory('', [[query_1, currentTime]], false)
      expect(retreivedHistory).toEqual([[query_1, currentTime]])
    })
  })

  describe('when historyQueries are blank', () => {
    it('returns history with provided query', () => {
      retreivedHistory = updateHistory(query_1, [], true)
      expect(retreivedHistory).toEqual([[query_1, currentTime]])
    })
  })

  describe('when historyQueries is undefined', () => {
    it('returns history with provided query', () => {
      retreivedHistory = updateHistory(query_1)
      expect(retreivedHistory).toEqual([[query_1, currentTime]])
    })
  })
})
