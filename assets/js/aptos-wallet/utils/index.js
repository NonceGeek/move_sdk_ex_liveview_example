export const toStringRecursive = (arg) => {
  if (Array.isArray(arg)) return arg.map(toStringRecursive)
  return `${arg}`
}
