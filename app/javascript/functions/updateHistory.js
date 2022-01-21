export default function updateHistory(query, historyQueriesArray = [], isLastValueDouble) {
  if (query.length < 1) { return historyQueriesArray }

  const timestamp = new Date()
  if (historyQueriesArray.length < 1) { return [[query, timestamp]] }

  const previousTimestamp = historyQueriesArray[historyQueriesArray.length - 1][1]
  const isLastValueSame = isSameQuery(query, historyQueriesArray[historyQueriesArray.length - 1])
  historyQueriesArray = withoutQuery(historyQueriesArray, query)

  isLastValueDouble && !isLastValueSame
    ? historyQueriesArray[historyQueriesArray.length - 1] = [query, previousTimestamp || timestamp]
    : historyQueriesArray.push([query, timestamp])

  return historyQueriesArray;
}

const withoutQuery = (array, query) => array.filter((record) => !isSameQuery(query, record))
const isSameQuery = (query, historyRecord) => query === historyRecord[0]
