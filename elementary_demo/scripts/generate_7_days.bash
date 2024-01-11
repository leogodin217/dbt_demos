dbt build -s models/final --vars '{run_at_date: current_date() - 7,  time_days_back: 7 }';
dbt build -s models/final --vars '{run_at_date: current_date() - 6,  time_days_back: 6 }';
dbt build -s models/final --vars '{run_at_date: current_date() - 5,  time_days_back: 5 }';
dbt build -s models/final --vars '{run_at_date: current_date() - 4,  time_days_back: 4 }';
dbt build -s models/final --vars '{run_at_date: current_date() - 3,  time_days_back: 3 }';
dbt build -s models/final --vars '{run_at_date: current_date() - 2,  time_days_back: 2 }';
dbt build -s models/final --vars '{run_at_date: current_date() - 1,  time_days_back: 1 }'