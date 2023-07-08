require 'test/unit'
require_relative 'Person'
require_relative 'PersonRepository'

class PersonRepositoryTest < Test::Unit::TestCase
  def setup
    @repository = PersonRepository.new
    @person1 = Person.new('Svan', 'Ivan', '1999-04-24', '4386736744')
    @person2 = Person.new('Serhii', 'Pertonymous', '2000-05-30', '6324673665')
  end

  def test_add_person
    @repository.add_person(@person1)
    assert_equal([@person1], @repository.people)

    assert_raise(ArgumentError) { @repository.add_person('not a person') }
    assert_raise(PersonAlreadyExist) { @repository.add_person(@person1) }
  end

  def test_edit_person_by_inn
    @repository.add_person(@person1)
    @repository.edit_person_by_inn('9876543210', 'Andrii', 'Lyashko', '1989-12-20')
    assert_equal('Andrii', @person1.first_name)
    assert_equal('Lyashko', @person1.last_name)
    assert_equal('1989-12-20', @person1.birth_date)

    assert_raise(PersonNotFoundError) { @repository.edit_person_by_inn('999999999', 'Andrii', 'Lyashko', '1989-12-20') }
  end

  def test_delete_person_by_inn
    @repository.add_person(@person1)
    @repository.add_person(@person2)
    @repository.delete_person_by_inn('9876543210')
    assert_equal([@person2], @repository.people)

    assert_raise(PersonNotFoundError) { @repository.delete_person_by_inn('9876543210') }
  end

  def test_get_by_inn
    @repository.add_person(@person1)
    assert_equal(@person1, @repository.get_by_inn('9876543210'))
    assert_nil(@repository.get_by_inn('999999999'))
  end

  def test_get_by_part_name
    @repository.add_person(@person1)
    @repository.add_person(@person2)
    assert_equal([@person1], @repository.get_by_part_name('Ivan'))
    assert_equal([@person2], @repository.get_by_part_name('Pertonymous'))
  end

  def test_get_by_date_range
    @repository.add_person(@person1)
    @repository.add_person(@person2)
    assert_equal([@person1], @repository.get_by_date_range(nil, '1989-12-20'))
    assert_equal([@person2], @repository.get_by_date_range('1989-12-20', nil))
    assert_equal([@person1, @person2], @repository.get_by_date_range(nil, nil))
  end
end
