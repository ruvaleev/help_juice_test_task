const { expect } = require('@jest/globals')

import updateHistory from '../../app/javascript/functions/updateHistory'

describe('updateHistory', () => {
  let retreivedHistory;
  const currentTime = new Date();

  jest
    .useFakeTimers()
    .setSystemTime(currentTime);

  it('returns upadted history', () => {
    const query = 'what is'
    retreivedHistory = updateHistory(query)
    expect(retreivedHistory).toEqual([[query, currentTime]]);
  })

  describe('when history includes repeated values', () => {
    it('returns history with actual query only, and ignores previous incomplete queries', () => {
      const query_1 = 'what is'
      const query_2 = 'What is a'
      const query_3 = 'What is a good car?'

      retreivedHistory = updateHistory(query_1)
      retreivedHistory = updateHistory(query_2, retreivedHistory)
      retreivedHistory = updateHistory(query_3, retreivedHistory)

      expect(retreivedHistory).toEqual([[query_3, currentTime]])
    })
  })

  describe('when history includes queries with typos', () => {
    it('returns history with actual query only, and ignores previous mistaken queries', () => {
      const query_1 = 'How is'
      const query_2 = 'Howis emil hajric'
      const query_3 = 'How is emil hajric doing?'

      retreivedHistory = updateHistory(query_1)
      retreivedHistory = updateHistory(query_2, retreivedHistory)
      retreivedHistory = updateHistory(query_3, retreivedHistory)

      expect(retreivedHistory).toEqual([[query_3, currentTime]])
    })
  })

  describe('when user uses backspace', () => {
    it('tracks changes correctly and writes to history only actually different queries', () => {
      const query_1 = 'Type something'
      const query_2 = 'pe something'
      const query_3 = 'type something'

      retreivedHistory = updateHistory(query_1)
      retreivedHistory = updateHistory(query_2, retreivedHistory)
      retreivedHistory = updateHistory(query_3, retreivedHistory)

      expect(retreivedHistory).toEqual([[query_3, currentTime]])
    })

    it("allows user to clear query and saves his last full request", () => {
      const query_1 = 'Type something'
      const query_2 = ''
      const query_3 = 'Type another'

      retreivedHistory = updateHistory(query_1)
      retreivedHistory = updateHistory(query_2, retreivedHistory)
      retreivedHistory = updateHistory(query_3, retreivedHistory)

      expect(retreivedHistory).toEqual([[query_1, currentTime], [query_3, currentTime]])
    })
  })
})
