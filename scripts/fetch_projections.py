import json
import os

# Sample ingestion template: In production, pull from nflverse, Sleeper API, or custom CSVs
def generate_projections():
    players_data = [
        {
            "name": "Patrick Mahomes",
            "position": "QB",
            "nflTeam": "KC",
            "age": 31,
            "injuryRisk": 0.05,
            "crimeRisk": 0.0,
            "teamTalentScore": 1.25,
            "projPassYds": 4650.0,
            "projPassTds": 36.0,
            "projRushYds": 340.0,
            "projRushTds": 2.0,
            "projRec": 0.0,
            "projRecYds": 0.0,
            "projRecTds": 0.0
        },
        {
            "name": "Breece Hall",
            "position": "RB",
            "nflTeam": "NYJ",
            "age": 25,
            "injuryRisk": 0.15,
            "crimeRisk": 0.0,
            "teamTalentScore": 1.10,
            "projPassYds": 0.0,
            "projPassTds": 0.0,
            "projRushYds": 1200.0,
            "projRushTds": 10.0,
            "projRec": 70.0,
            "projRecYds": 610.0,
            "projRecTds": 4.0
        },
        {
            "name": "Ja'Marr Chase",
            "position": "WR",
            "nflTeam": "CIN",
            "age": 26,
            "injuryRisk": 0.08,
            "crimeRisk": 0.0,
            "teamTalentScore": 1.20,
            "projPassYds": 0.0,
            "projPassTds": 0.0,
            "projRushYds": 20.0,
            "projRushTds": 0.0,
            "projRec": 110.0,
            "projRecYds": 1480.0,
            "projRecTds": 12.0
        },
        {
            "name": "Travis Kelce",
            "position": "TE",
            "nflTeam": "KC",
            "age": 37,
            "injuryRisk": 0.22,
            "crimeRisk": 0.0,
            "teamTalentScore": 1.20,
            "projPassYds": 0.0,
            "projPassTds": 0.0,
            "projRushYds": 0.0,
            "projRushTds": 0.0,
            "projRec": 78.0,
            "projRecYds": 810.0,
            "projRecTds": 6.0
        },
        {
            "name": "C.J. Stroud",
            "position": "QB",
            "nflTeam": "HOU",
            "age": 25,
            "injuryRisk": 0.05,
            "crimeRisk": 0.0,
            "teamTalentScore": 1.20,
            "projPassYds": 4500.0,
            "projPassTds": 32.0,
            "projRushYds": 210.0,
            "projRushTds": 3.0,
            "projRec": 0.0,
            "projRecYds": 0.0,
            "projRecTds": 0.0
        },
        {
            "name": "Bijan Robinson",
            "position": "RB",
            "nflTeam": "ATL",
            "age": 24,
            "injuryRisk": 0.06,
            "crimeRisk": 0.0,
            "teamTalentScore": 1.15,
            "projPassYds": 0.0,
            "projPassTds": 0.0,
            "projRushYds": 1250.0,
            "projRushTds": 11.0,
            "projRec": 65.0,
            "projRecYds": 540.0,
            "projRecTds": 4.0
        }
    ]

    target_dir = os.path.join(os.path.dirname(__file__), "..", "assets", "data")
    os.makedirs(target_dir, exist_ok=True)
    out_path = os.path.join(target_dir, "players.json")

    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(players_data, f, indent=2)

    print(f"Successfully generated {len(players_data)} player records to {out_path}")

if __name__ == "__main__":
    generate_projections()