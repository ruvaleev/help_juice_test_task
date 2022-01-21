export default function actualQuery(query, queryVariants) {
  if (!queryVariants || queryVariants.length < 1) { return query }

  const longestQuery = maxByLength(queryVariants)

  return query.length >= longestQuery.length ? query : longestQuery
}

const maxByLength = (array) => array.sort((x, y) => x.length > y.length ? -1 : 1)[0]
