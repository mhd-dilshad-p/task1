/// Small helpers and formatters used across the app

String shorten(String s, [int max = 30]) {
  if (s.length <= max) return s;
  return s.substring(0, max - 3) + '...';
}
