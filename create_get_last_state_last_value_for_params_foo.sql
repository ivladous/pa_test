DROP FUNCTION get_current_data(integer);
CREATE FUNCTION get_current_data(N int)
RETURNS TABLE (
	name VARCHAR,
	state_timestamp TIMESTAMPTZ,
	last_state BOOL,
	value_timestamp TIMESTAMPTZ,
	last_value REAL
	
)
LANGUAGE plpgsql STABLE
AS $$
BEGIN
	RETURN QUERY (
		SELECT p.name name, s.time state_timestamp, s.state last_state, v.time value_timestamp, v.value last_value 
		FROM scada.parameters p
		LEFT JOIN LATERAL(SELECT * FROM scada.states WHERE parameter_id=p.id ORDER BY time DESC LIMIT 1) s ON TRUE
		LEFT JOIN LATERAL(SELECT * FROM scada.values WHERE parameter_id=p.id ORDER BY time DESC LIMIT 1) v ON TRUE
		WHERE v.time >= current_timestamp - interval '1 minute' * N
	);
END $$;
