#!/bin/env bash
for outer_loop in $(seq 6); do
  # Drop all existing tables
  psql -U scuser big_table < drop_tables.sql &> /dev/null
  # Create the system of tables
  psql -U scuser big_table < create_tables.sql &> /dev/null
  # Insert necessary values
  psql -U scuser big_table < setup_tables.sql &> /dev/null
  # Now fill the data table with entries.
  python insert_alchemy.py $outer_loop 
  # Insert a break in the data file to make it easier to read
  echo "---$outer_loop---" >> bench_data
  for inner_loop in $(seq 10); do
    # Run the benchmarks 10 times for statistics
    psql -U scuser big_table < unit_tests.sql | grep 'runtime' | awk '{print $3}' | tee -a bench_data
  done
done

