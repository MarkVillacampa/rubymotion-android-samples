class MainActivity < Android::Support::V7::App::AppCompatActivity
  attr_accessor :view_pager

  def onCreate(savedInstanceState)
    super
    self.contentView = R::Layout::Pager
    self.view_pager = self.findViewById(R::Id::Pager)

    adapter = DemoCollectionPagerAdapter.new(supportFragmentManager)
    view_pager.adapter = adapter
    view_pager.addOnPageChangeListener(self)

    action_bar = supportActionBar

    # Specify that tabs should be displayed in the action bar.
    action_bar.setNavigationMode(Android::Support::V7::App::ActionBar::NAVIGATION_MODE_TABS)

    # Add tabs
    3.times do |i|
      tab = action_bar.newTab.setText("Tab #{i + 1}").setTabListener(self)
      actionBar.addTab(tab)
    end
  end

  # interface: android.app.ActionBar.TabListener

  def onTabSelected(tab, fragmentTransation)
    # show the given tab
    view_pager.currentItem = tab.position
  end

  def onTabUnselected(tab, fragmentTransaction)
    # hide the given tab
  end

  def onTabReselected(tab, fragmentTransaction)
    # ignore this event
  end

  # interface: android.support.v4.view.ViewPager.OnPageChangeListener

  def onPageSelected(position)
    supportActionBar.selectedNavigationItem = position
  end

  def onPageScrollStateChanged(state)
    # ignore this event
  end

  def onPageScrolled(position, positionOffset, positionOffsetPixels)
    # ignore this event
  end
end

class DemoCollectionPagerAdapter < Android::Support::V4::App::FragmentStatePagerAdapter
  def getItem(i)
    fragment = DemoObjectFragment.new
    args = Android::OS::Bundle.new
    args.putInt("index", i + 1)
    fragment.arguments = args
    fragment
  end

  def getCount
    3
  end

  def getPageTitle(position)
    "Tab #{position + 1}"
  end
end

class DemoObjectFragment < Android::Support::V4::App::Fragment
  def onCreateView(inflater, container, savedInstanceState)
    text_view = Android::Widget::TextView.new(context)
    text_view.textSize = 18
    text_view.setTypeface(nil, Android::Graphics::Typeface::BOLD)
    text_view.textColor = Android::Graphics::Color::BLACK
    text_view.enabled = false
    text_view.text = getArguments.getInt("index").to_s
    text_view
  end
end
