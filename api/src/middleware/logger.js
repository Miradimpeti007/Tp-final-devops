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

<<<<<<< HEAD
=======
function getLevel(status) {
  if (status >= 500) return "error";
  if (status >= 400) return "warn";
  return "info";
}

function generateRequestId() {
  return Date.now().toString(36) + Math.random().toString(36).substr(2, 9);
}

>>>>>>> origin/develop
module.exports = function logger(req, res, next) {
  const startedAt = Date.now();
  const requestId = req.headers["x-request-id"] || generateRequestId();

  req.requestId = requestId;
  res.setHeader("X-Request-Id", requestId);

  res.on("finish", () => {
    console.log(
      JSON.stringify({
        level: getLevel(res.statusCode),
        request_id: requestId,
        method: req.method,
        path: sanitizeUrl(req.originalUrl),
        status: res.statusCode,
        duration_ms: Date.now() - startedAt,
        timestamp: new Date().toISOString(),
      })
    );
  });

  next();
};
