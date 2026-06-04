const request = require("supertest");

jest.mock("../src/db", () => ({ query: jest.fn() }));
const db = require("../src/db");
const app = require("../src/app");

describe("GET /products", () => {
  it("retourne la liste des produits depuis la DB", async () => {
    db.query.mockResolvedValueOnce({
      rows: [
        { id: 1, name: "T-shirt", description: "Basique", price_cents: 1999 },
        { id: 2, name: "Casquette", description: "Style", price_cents: 1299 }
      ]
    });
    const res = await request(app).get("/products");
    expect(res.status).toBe(200);
    expect(res.body.source).toBe("database");
    expect(Array.isArray(res.body.data)).toBe(true);
    expect(res.body.data).toHaveLength(2);
    expect(res.body.data[0]).toHaveProperty("name");
    expect(res.body.data[0]).toHaveProperty("price_cents");
  });

  it("retourne une liste vide si aucun produit en base", async () => {
    db.query.mockResolvedValueOnce({ rows: [] });
    const res = await request(app).get("/products");
    expect(res.status).toBe(200);
    expect(res.body.data).toHaveLength(0);
  });

  it("retourne 500 si la DB est indisponible", async () => {
    db.query.mockRejectedValueOnce(new Error("Connexion DB perdue"));
    const res = await request(app).get("/products");
    expect(res.status).toBe(500);
  });
});
