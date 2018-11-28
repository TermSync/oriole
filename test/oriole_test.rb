require 'test_helper'

class Oriole::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Oriole
  end

  def test_or_creates_compound_where_clause
    relation = Post.where.or({ title: "hello" }, { author_id: [1, 2] }, 'body = "Greetings"')
    expected_where_clause = Post.where(title: "hello")
      .or(Post.where(author_id: [1, 2]))
      .or(Post.where('body = "Greetings"'))
      .where_clause

    assert_equal expected_where_clause, relation.where_clause
  end

  def test_or_with_nil
    assert_raise ArgumentError do
      Post.where.or(nil)
    end
  end

  def test_or_with_preceding_where
    actual = Post.where(title: "hello").where.or({ body: "world" }, { author_id: [1, 2] }).to_sql

    base = Post.where(title: "hello")
    expected = base.where(body: "world").or(base.where(author_id: [1, 2])).to_sql

    assert_equal expected, actual
  end

  def test_or_with_following_where
    relation = Post.where.or({ title: "hello" }, { body: "friend" }).where(author_id: [1, 2])
    expected_where_clause =
      Post.where.or({ title: "hello" }, { body: "friend" }).where_clause +
      Post.where(author_id: [1, 2]).where_clause

    assert_equal expected_where_clause, relation.where_clause
  end

  def test_chaining_multiple_ors
    actual = Post.where.or({ author_id: [1, 2] }, { title: "Hello" })
      .where.or({ title: "ruby on rails" }, { author_id: [3, 4], body: "World" })
      .to_sql

    base = Post.where(author_id: [1, 2]).or(Post.where(title: "Hello"))
    expected = base.where(title: "ruby on rails").or(base.where(author_id: [3, 4], body: "World")).to_sql

    assert_equal expected, actual
  end
end
