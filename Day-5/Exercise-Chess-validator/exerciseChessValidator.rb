class Board
	def initialize chess_validator
		@chess_validator = chess_validator
		@board = create_board
	end

	def create_board
		board = Array.new(8) { Array.new 8 }
		board[7][0] = :wR
		board[0][0] = :bR
		board
	end

	def mapping_algebraic_notation_to_array algebraicNotation
		if algebraicNotation.length == 2
			puts [(algebraicNotation[0].ord - 48).chr, algebraicNotation[1]]
		end
	end

	def move ini_pos, end_pos, board = @board
		@chess_validator.is_legal_move? ini_pos, end_pos, board
	end
end

class ChessValidator
	COLOR = {
		'W': 'White',
		'B': 'Black'
	}

	PIECES = {
		'R': 'Rook'
	}
	
	def is_legal_move? ini_pos, end_pos, board
		is_legal_move = false
		square_empty = square_empty? end_pos, board
		if square_empty
			piece = get_piece ini_pos, end_pos, board
			is_legal_move = piece.can_move? ini_pos, end_pos if piece
		end
		is_legal_move
	end

	def square_empty? pos, board
		(board[pos[0]][pos[1]]).nil?
	end

	def get_piece ini_pos, end_pos, board
		piece = board[ini_pos[0]][ini_pos[1]]
		(Object.const_get PIECES[piece[1].to_sym]).new piece[0] if piece
	end
end

class Piece
	attr_reader :color

	def initialize color
		@color = color
	end
end

class Rook < Piece
	def initialize color
		super
	end

	def can_move? ini_pos, end_pos
		ini_pos[0] == end_pos[0] || ini_pos[1] == end_pos[1]
	end
end

board = Board.new(ChessValidator.new)
puts board.move([7, 0], [0, 0])
puts board.mapping_algebraic_notation_to_array 'e4'