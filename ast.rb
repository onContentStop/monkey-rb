# frozen_string_literal: true

module Node
  def token_literal
    @token.literal
  end

  def string
    raise NotImplementedError, "please implement me :'("
  end
end

class Program
  include Node

  def initialize(statements)
    @statements = statements
  end

  def token_literal
    if @statements.empty?
      ''
    else
      @statements[0].token_literal
    end
  end

  def string
    @statements.map(&:string).join("\n")
  end

  attr_reader :statements
end

class LetStatement
  include Node

  def initialize(token, name, value)
    @token = token
    @name = name
    @value = value
  end

  def string
    result = "#{token_literal} #{@name.string} = "
    result << @value.string unless @value.nil?
    result << ';'
    result
  end

  attr_reader :token, :name, :value
end

class Identifier
  include Node

  def initialize(token, value)
    @token = token
    @value = value
  end

  def string
    token_literal
  end

  attr_reader :token, :value
end

class ReturnStatement
  include Node

  def initialize(token, return_value)
    @token = token
    @return_value = return_value
  end

  def string
    result = "#{token_literal} "
    result << return_value.string unless @return_value.nil?
    result << ';'
  end

  attr_reader :token, :return_value
end

class ExpressionStatement
  include Node

  def initialize(token, expression)
    @token = token
    @expression = expression
  end

  def string
    if @expression.nil?
      ''
    else
      @expression.string
    end
  end

  attr_reader :token, :expression
end
