class Relation
  attr_reader :params, :query, :klass

  def initialize(klass)
    @klass = klass
    @params = {}
    @query = nil
  end

  [:where, :having].each do |name|
    define_method(name) do |params|
      assign_hash(name, params)
      self
    end
  end

  [:select, :group, :limit, :order, :offset].each do |name|
    define_method(name) do |*params|
      assign_value(name, params.flatten)
      self
    end
  end

  def find_nth(idx)
    run_query
    @params = {}
    @query[idx]
  end

  def all
    run_query
    @params = {}
    self
  end

  [:first, :second, :third, :fourth, :fifth].each_with_index do |name, idx|
    define_method(name) do
      find_nth idx
    end
  end

  [:last, :second_to_last, :third_to_last].each_with_index do |name, idx|
    define_method(name) do
      find_nth -1 * idx
    end
  end

  private

  def assign_hash(method_name, params)
    @params[method_name] ||= {}
    params.each do |attr_name, value|
      @params[method_name][attr_name] = value
    end
  end

  def assign_value(method_name, value)
    @params[method_name] ||= []
    @params[method_name] += value
  end

  def run_query
    query = DBConnection.execute(<<-SQL, *where_values, *having_values)
      SELECT #{select_str}
      FROM #{@klass.table_name}
      #{where_str}
      #{group_str}
      #{having_str}
      #{order_str}
      #{limit_str}
      #{offset_str}
    SQL

    @query = query
    self
  end

  def select_str
    select_conditions = @params[:select]
    select_conditions.nil? ? '*' : select_conditions.join(', ')
  end

  def where_str
    where_conditions = @params[:where]
    if where_conditions.nil?
      ''
    else
      where_str = where_conditions.map { |attr_name, _| "#{attr_name} = ?" }
                            .join(' AND ')
      "WHERE #{where_str}"
    end
  end

  def where_values
    where_conditions = @params[:where]
    where_conditions.nil? ? [] : where_conditions.values
  end

  def group_str
    group_conditions = @params[:group]
    group_conditions.nil? ? '' : 'GROUP BY ' + group_conditions.join(',')
  end

  def having_str
    having_conditions = @params[:having]
    if having_conditions.nil?
      ''
    else
      having_str = having_conditions.map { |attr_name, _| "#{attr_name} = ?" }
                            .join(' AND ')
      "HAVING #{having_str}"
    end
  end

  def having_values
    having_conditions = @params[:having]
    having_conditions.nil? ? [] : having_conditions.values
  end

  def order_str
    order_conditions = @params[:order]
    order_conditions.nil? ? '' : 'ORDER BY ' + order_conditions.join(',')
  end

  def limit_str
    limit_conditions = @params[:limit]
    limit_conditions.nil? ? '' : 'LIMIT ' + limit_conditions.join(',')
  end

  def offset_str
    offset_conditions = @params[:offset]
    offset_conditions.nil? ? '' : 'GROUP BY ' + offset_conditions.join(',')
  end


end
