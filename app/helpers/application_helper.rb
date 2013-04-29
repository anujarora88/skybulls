module ApplicationHelper

  def available_cash
    if current_user
      humanized_money_with_symbol current_user.account.balance
    end

  end

  def current_user_name(max_length)
    name = current_user.display_name
    name.length > max_length ? name[0, max_length-2]+'..' : name
  end

  def render_left_sidebar_tab(options)
    options.symbolize_keys!

    href = options[:href]
    if current_page?(href)
       options[:class_name] = options[:class] + ' active'
    end
    yield(options)
  end

end
