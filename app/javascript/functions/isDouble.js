export default function isDouble(query, lastQueryVariation) {
  if (!lastQueryVariation) { return }

  const normalizedQuery = forCompare(query)
  const normalizedPreviousQuery = forCompare(lastQueryVariation)

  return (
    normalizedQuery.includes(normalizedPreviousQuery) || normalizedPreviousQuery.includes(normalizedQuery)
  )
}

const forCompare = (string) => string.toLowerCase().replace(/\s/g, '')
