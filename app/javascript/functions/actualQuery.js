export default function actualQuery(query, queryVariations) {
  if (!queryVariations || queryVariations.length < 1) { return query }

  return(
    queryVariations.find((previousQuery) => previousQuery.length > query.length) || query
  )
}
