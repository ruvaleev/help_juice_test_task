export default function updateHistory(query, historyQueriesArray = []) {
  if (query.length < 1) { return historyQueriesArray }

  const isDouble =
    isQueryDoubled(query, historyQueriesArray[historyQueriesArray.length - 1])

  if (isDouble) {
    const timeStamp = historyQueriesArray[historyQueriesArray.length - 1][1]
    historyQueriesArray[historyQueriesArray.length - 1] = [query, timeStamp]
  } else {
    historyQueriesArray = [...historyQueriesArray, [query, new Date()]]
  }

  return historyQueriesArray;
}

function isQueryDoubled(query, previousQuery) {
  if (!previousQuery) { return }

  const normalizedQuery = forCompare(query)
  const normalizedPreviousQuery = forCompare(previousQuery[0])

  return (
    normalizedQuery.includes(normalizedPreviousQuery) || normalizedPreviousQuery.includes(normalizedQuery)
  )
}

const forCompare = (string) => string.toLowerCase().replace(/\s/g, '')
