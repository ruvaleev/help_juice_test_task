export default function isDouble(query, lastQueryVariant) {
  if (!lastQueryVariant) { return }

  const normalizedQuery = forCompare(query)
  const normalizedPreviousQuery = forCompare(lastQueryVariant)

  return (
    normalizedQuery.includes(normalizedPreviousQuery) || normalizedPreviousQuery.includes(normalizedQuery)
  )
}

const forCompare = (string) => string.toLowerCase().replace(/\s/g, '')
