note
	description: "bowling2 application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	GAME
create
	make
feature
	counter: INTEGER
	rolls: ARRAY[INTEGER]
feature
	make
		do
			counter := 0
			create rolls.make_filled (0, 0, 22)
			print ("New Game started%N")
		end
feature
	roll (pins:INTEGER)
		do
			rolls.enter (pins, counter)
			counter := counter +1
		end
	score : INTEGER
		local
			total_score:INTEGER
			roll_index:INTEGER
			i: INTEGER
		do
			total_score := 0
			roll_index := rolls.lower

			from
				i := 0
			until
				i >= 10
			loop
				if rolls.valid_index(roll_index)
					and rolls.valid_index (roll_index + 1)
					and rolls.valid_index (roll_index + 2)
					and is_strike(roll_index)
				then
					print("STRIKE%N")
					total_score := total_score + 10 + rolls.at (roll_index + 1) + rolls.at (roll_index + 2)
					roll_index := roll_index + 1
				elseif rolls.valid_index(roll_index)
					and rolls.valid_index (roll_index + 1)
					and rolls.valid_index (roll_index + 2)
					and is_spare(roll_index)
				then
					print("SPARE%N")
					total_score := total_score + rolls.at (roll_index) + rolls.at (roll_index + 1) + rolls.at (roll_index + 2)
					roll_index := roll_index + 2
				elseif rolls.valid_index (roll_index)
					and rolls.valid_index (roll_index + 1)
				then
					print("SCORE%N")
					total_score := total_score + rolls.at (roll_index) + rolls.at (roll_index + 1)
					roll_index := roll_index + 2
				end
				i := i + 1
			variant
				10 - i
			end
			print("Score is ");print(total_score);print("%N")
			Result := total_score
		end
feature {NONE}
	is_strike (index:INTEGER):BOOLEAN
		require
			rolls.valid_index (index)
		do
			Result := (rolls.at(index) = 10)
		end
	is_spare (index:INTEGER):BOOLEAN
		require
			rolls.valid_index (index)
		do
			Result := ((rolls.at(index) + rolls.at(index + 1)) = 10)
		end
end
