import json
import os
import requests

# Curated baseline projection pool (yards, touchdowns, receptions)
PROJECTIONS_BASE = [
    {
        "name": "Patrick Mahomes",
        "position": "QB",
        "nflTeam": "KC",
        "age": 31,
        "projPassYds": 4450.0,
        "projPassTds": 34.0,
        "projRushYds": 380.0,
        "projRushTds": 3.0,
        "projRec": 0.0,
        "projRecYds": 0.0,
        "projRecTds": 0.0,
    },
    {
        "name": "C.J. Stroud",
        "position": "QB",
        "nflTeam": "HOU",
        "age": 25,
        "projPassYds": 4300.0,
        "projPassTds": 28.0,
        "projRushYds": 190.0,
        "projRushTds": 2.0,
        "projRec": 0.0,
        "projRecYds": 0.0,
        "projRecTds": 0.0,
    },
    {
        "name": "Josh Allen",
        "position": "QB",
        "nflTeam": "BUF",
        "age": 30,
        "projPassYds": 4100.0,
        "projPassTds": 30.0,
        "projRushYds": 520.0,
        "projRushTds": 9.0,
        "projRec": 0.0,
        "projRecYds": 0.0,
        "projRecTds": 0.0,
    },
    {
        "name": "Bijan Robinson",
        "position": "RB",
        "nflTeam": "ATL",
        "age": 24,
        "projPassYds": 0.0,
        "projPassTds": 0.0,
        "projRushYds": 1450.0,
        "projRushTds": 12.0,
        "projRec": 65.0,
        "projRecYds": 520.0,
        "projRecTds": 4.0,
    },
    {
        "name": "Breece Hall",
        "position": "NYJ",
        "nflTeam": "NYJ",
        "age": 25,
        "projPassYds": 0.0,
        "projPassTds": 0.0,
        "projRushYds": 1150.0,
        "projRushTds": 9.0,
        "projRec": 70.0,
        "projRecYds": 590.0,
        "projRecTds": 4.0,
    },
    {
        "name": "Jahmyr Gibbs",
        "position": "RB",
        "nflTeam": "DET",
        "age": 24,
        "projPassYds": 0.0,
        "projPassTds": 0.0,
        "projRushYds": 1100.0,
        "projRushTds": 11.0,
        "projRec": 60.0,
        "projRecYds": 480.0,
        "projRecTds": 3.0,
    },
    {
        "name": "Ja'Marr Chase",
        "position": "WR",
        "nflTeam": "CIN",
        "age": 26,
        "projPassYds": 0.0,
        "projPassTds": 0.0,
        "projRushYds": 15.0,
        "projRushTds": 0.0,
        "projRec": 105.0,
        "projRecYds": 1480.0,
        "projRecTds": 12.0,
    },
    {
        "name": "Justin Jefferson",
        "position": "WR",
        "nflTeam": "MIN",
        "age": 27,
        "projPassYds": 0.0,
        "projPassTds": 0.0,
        "projRushYds": 20.0,
        "projRushTds": 0.0,
        "projRec": 110.0,
        "projRecYds": 1550.0,
        "projRecTds": 10.0,
    },
    {
        "name": "Amon-Ra St. Brown",
        "position": "WR",
        "nflTeam": "DET",
        "age": 27,
        "projPassYds": 0.0,
        "projPassTds": 0.0,
        "projRushYds": 35.0,
        "projRushTds": 1.0,
        "projRec": 115.0,
        "projRecYds": 1350.0,
        "projRecTds": 10.0,
    },
    {
        "name": "Travis Kelce",
        "position": "TE",
        "nflTeam": "KC",
        "age": 37,
        "projPassYds": 0.0,
        "projPassTds": 0.0,
        "projRushYds": 0.0,
        "projRushTds": 0.0,
        "projRec": 82.0,
        "projRecYds": 910.0,
        "projRecTds": 6.0,
    },
    {
        "name": "Trey McBride",
        "position": "TE",
        "nflTeam": "ARI",
        "age": 26,
        "projPassYds": 0.0,
        "projPassTds": 0.0,
        "projRushYds": 0.0,
        "projRushTds": 0.0,
        "projRec": 88.0,
        "projRecYds": 940.0,
        "projRecTds": 5.0,
    },
]

def fetch_and_enrich():
    # Attempt to fetch live player statuses and teams from Sleeper API
    try:
        res = requests.get("https://api.sleeper.app/v1/players/nfl", timeout=10)
        sleeper_data = res.json() if res.status_code == 200 else {}
    except Exception:
        sleeper_data = {}

    name_map = {
        p.get("full_name"): p
        for p in sleeper_data.values()
        if p.get("full_name")
    }

    enriched = []
    for player in PROJECTIONS_BASE:
        sleeper_info = name_map.get(player["name"], {})
        
        # Pull live injury risk multiplier based on active status
        injury_status = sleeper_info.get("injury_status")
        injury_weight = 0.0
        if injury_status in ["Questionable", "Doubtful"]:
            injury_weight = 0.25
        elif injury_status in ["Out", "IR", "PUP"]:
            injury_weight = 0.70

        enriched.append({
            "name": player["name"],
            "position": player["position"],
            "nflTeam": sleeper_info.get("team") or player["nflTeam"],
            "age": sleeper_info.get("age") or player["age"],
            "injuryRisk": injury_weight,
            "crimeRisk": 0.0,
            "teamTalentScore": 1.0,
            "projPassYds": player["projPassYds"],
            "projPassTds": player["projPassTds"],
            "projRushYds": player["projRushYds"],
            "projRushTds": player["projRushTds"],
            "projRec": player["projRec"],
            "projRecYds": player["projRecYds"],
            "projRecTds": player["projRecTds"],
        })

    out_path = os.path.join("assets", "data", "players.json")
    with open(out_path, "w") as f:
        json.dump(enriched, f, indent=2)
    print(f"Enriched {len(enriched)} players written to {out_path}")

if __name__ == "__main__":
    fetch_and_enrich()