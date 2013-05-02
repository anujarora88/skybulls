module ApplicationHelper

  include ActionView::Helpers::TagHelper

  def available_cash
    if current_user
      humanized_money_with_symbol current_user.account.balance
    end

  end

  def current_user_name(max_length, &block)
    name = current_user.display_name
    name.length > max_length ? name[0, max_length-2]+'..' : name
  end

  def render_left_sidebar_tab(options, &block)
    options.symbolize_keys!

    href = options[:href]
    if current_page?(href)
      if options[:class]
        options[:class] = options[:class] + ' active'
      else
        options[:class] = 'active'
      end

    end
    content_tag :a, options, block
  end

  def humanize_time(secs)
    secs = secs.to_time if secs.respond_to? :to_time
    time_string = [[60, :seconds], [60, :minutes], [24, :hours], [1000, :days]].map{ |count, name|
      if secs > 0
        secs, n = secs.divmod(count)
        "#{n.to_i} #{name}"
      end
    }.compact.reverse.join(', ')
    secs > Time.now ? "#{time_string} ago" : "After #{time_string}"
  end

end
