const request = require("supertest");

jest.mock("../src/db", () => ({ query: jest.fn() }));
const db = require("../src/db");
const app = require("../src/app");

describe("GET /", () => {
  it("retourne le nom de l'API", async () => {
    const res = await request(app).get("/");
    expect(res.status).toBe(200);
    expect(res.body.name).toBe("ShopLite API");
  });
});

describe("GET /health", () => {
  it("retourne ok quand la DB est disponible", async () => {
    db.query.mockResolvedValueOnce({ rows: [{ "?column?": 1 }] });
    const res = await request(app).get("/health");
    expect(res.status).toBe(200);
    expect(res.body.status).toBe("ok");
    expect(res.body.checks.database).toBe("ok");
    expect(res.body).toHaveProperty("version");
    expect(res.body).toHaveProperty("timestamp");
  });

  it("retourne 503 quand la DB est indisponible", async () => {
    db.query.mockRejectedValueOnce(new Error("DB indisponible"));
    const res = await request(app).get("/health");
    expect(res.status).toBe(503);
    expect(res.body.checks.database).toBe("error");
  });
});

describe("GET /ready", () => {
  it("retourne ready:true quand la DB est disponible", async () => {
    db.query.mockResolvedValueOnce({ rows: [{ "?column?": 1 }] });
    const res = await request(app).get("/ready");
    expect(res.status).toBe(200);
    expect(res.body.ready).toBe(true);
  });

  it("retourne 503 quand la DB est indisponible", async () => {
    db.query.mockRejectedValueOnce(new Error("DB indisponible"));
    const res = await request(app).get("/ready");
    expect(res.status).toBe(503);
    expect(res.body.ready).toBe(false);
  });
});

describe("Routes inconnues", () => {
  it("retourne 404 sur une route inexistante", async () => {
    const res = await request(app).get("/route-inconnue");
    expect(res.status).toBe(404);
  });
});
