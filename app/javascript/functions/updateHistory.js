export default function updateHistory(query, historyQueriesArray = [], isDouble) {
  if (query.length < 1) { return historyQueriesArray }

  const timestamp = new Date()
  if (historyQueriesArray.length < 1) { return [[query, timestamp]] }

  const previousTimestamp = new Date(historyQueriesArray[historyQueriesArray.length - 1][1])

  isDouble
    ? historyQueriesArray[historyQueriesArray.length - 1] = [query, previousTimestamp]
    : historyQueriesArray.push([query, timestamp])

  return historyQueriesArray;
}
