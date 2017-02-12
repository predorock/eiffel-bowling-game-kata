note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	GAME_TEST_SET

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

feature {NONE}
	game: GAME

feature {NONE} -- Events
	on_prepare
			-- <Precursor>
		do
			print("on prepare%N")
			create game.make
			--assert ("not_implemented", False)
		end

	on_clean
			-- <Precursor>
		do
			print("on clean%N")
			--assert ("not_implemented", False)
		end

feature {NONE} -- Utility routines
	roll_many (shots: INTEGER; pins: INTEGER)
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i >= shots
			loop
				game.roll(pins)
				i := i + 1
			end
		end
	roll_spare
		do
			roll_many(2,5)
		end
	roll_strike
		do
			game.roll (10)
		end
feature
	test_gutter_game
		do
			roll_many(20, 0)
			assert("score should be zero", game.score = 0)
		end
	test_all_ones
		do
			roll_many(20,1)
			assert("score should be 20", game.score = 20 )
		end
	test_one_spare
		do
			roll_spare
			game.roll(3)
			roll_many(17, 0)
			assert("score should be 16", game.score = 16)
		end
	test_one_strike
		do
			roll_strike
			game.roll (3)
			game.roll (4)
			roll_many (16,0)
			assert("score should be 24", game.score = 24)
		end
	test_perfect_game
		do
			roll_many(12, 10)
			assert("score should be 300", game.score = 300)
		end
	test_last_spare
		do
			roll_many (9,10)
			roll_spare
			game.roll (10)
			assert("score should be 275", game.score = 275)
		end
end


