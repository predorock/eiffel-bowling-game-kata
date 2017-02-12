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
			print("Rolling ");print(pins);print(" at index ");print(counter);print("%N")
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
			roll_index := 0

			from
				i := 0
			until
				i >= 10
			loop
				if is_strike(roll_index)
				then
					total_score := total_score + 10 + rolls.at (roll_index + 1) + rolls.at (roll_index + 2)
					roll_index := roll_index + 1
				elseif is_spare(roll_index)
				then
					total_score := total_score + rolls.at (roll_index) + rolls.at (roll_index + 2)
					roll_index := roll_index + 2
				else
					total_score := total_score + rolls.at (roll_index) + rolls.at (roll_index + 1)
					roll_index := roll_index + 2
				end
			end
			print("Score is ");print(total_score);print("%N")
			Result := total_score
		end
feature {NONE}
	is_strike (index:INTEGER):BOOLEAN
		do
			Result := (rolls.at(index) = 10)
		end
	is_spare (index:INTEGER):BOOLEAN
		do
			Result := ((rolls.at(index) + rolls.at(index + 1)) = 10)
		end
end
