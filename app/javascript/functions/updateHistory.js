export default function updateHistory(query, historyQueriesArray = []) {
  if (query.length < 1) { return }

  const isDouble =
    isQueryDoubled(query, historyQueriesArray[historyQueriesArray.length - 1])

  if (isDouble) {
    historyQueriesArray[historyQueriesArray.length - 1] = query
  } else {
    historyQueriesArray = [...historyQueriesArray, query]
  }

  return historyQueriesArray;
}

function isQueryDoubled(query, previousQuery) {
  if (!previousQuery) { return }

  const normalizedQuery = forCompare(query)
  const normalizedPreviousQuery = forCompare(previousQuery)

  return (
    normalizedQuery.includes(normalizedPreviousQuery) || normalizedPreviousQuery.includes(normalizedQuery)
  )
}

const forCompare = (string) => string.toLowerCase().replace(/\s/g, '')
