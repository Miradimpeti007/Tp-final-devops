const SENSITIVE_KEYS = ["password", "token", "secret", "authorization", "key"];

function sanitizeUrl(url) {
  try {
    const parsed = new URL(url, "http://localhost");
    for (const key of parsed.searchParams.keys()) {
      if (SENSITIVE_KEYS.some((s) => key.toLowerCase().includes(s))) {
        parsed.searchParams.set(key, "[MASKED]");
      }
    }
    return parsed.pathname + (parsed.search || "");
  } catch {
    return url;
  }
}

module.exports = function logger(req, res, next) {
  const startedAt = Date.now();

  res.on("finish", () => {
    console.log(
      JSON.stringify({
        level: "info",
        method: req.method,
        path: sanitizeUrl(req.originalUrl),
        status: res.statusCode,
        duration_ms: Date.now() - startedAt,
        timestamp: new Date().toISOString()
      })
    );
  });

  next();
};
