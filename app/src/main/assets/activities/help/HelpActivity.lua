require "environment"
import "com.androlua.adapter.LuaAdapter"
import "android.view.KeyEvent"
import "android.view.WindowManager"
import "android.view.View"
import "android.graphics.drawable.ColorDrawable"
local LuaFileUtil = luajava.bindClass "com.nekolaska.io.LuaFileUtil".INSTANCE
local ColorUtil = this.globalData.ColorUtil
local res = res
activity.setTitle("NeLuaJ+" .. res.string.help)
        .setContentView(res.layout.help_layout)
        .getSupportActionBar() {
    Elevation = 0,
    BackgroundDrawable = ColorDrawable(ColorUtil.getColorBackground()),
    DisplayShowTitleEnabled = true,
    DisplayHomeAsUpEnabled = true
}

local window = activity.getWindow()
                       .setNavigationBarColor(0)
                       .setStatusBarColor(ColorUtil.getColorBackground())
                       .addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
                       .clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
if this.isNightMode() then
    window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_VISIBLE)
else
    window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
end

function onOptionsItemSelected(m)
    if m.getItemId() == android.R.id.home then
        if vpg.getCurrentItem() ~= 0 then
            vpg.setCurrentItem(0)
            activity.setTitle("NeLuaJ+" .. res.string.help)
        else
            activity.finish()
        end
    end
end

--luajava.newInstance("me.zhanghai.android.fastscroll.FastScrollerBuilder", webView).useMd2Style().build()

local MaterialTextView = luajava.bindClass "com.google.android.material.textview.MaterialTextView"
local LinearLayout = luajava.bindClass "android.widget.LinearLayout"
local item = {
    LinearLayout,
    layout_height = "-2",
    layout_width = "-1",
    paddingLeft = "16dp",
    paddingRight = "16dp",
    paddingTop = "12dp",
    paddingBottom = "12dp",
    {
        MaterialTextView,
        id = "text",
        layout_height = "-2",
        layout_width = "-1",
        textColor = ColorUtil.getColorPrimary(),
        textSize = "16dp",
    },
}

local data = {
    { text = res.string.overview, file = "overview.md" },
    { text = "LuaJ++", file = "LuaJ++.md" },
    { text = "LuaActivity", file = "LuaActivity.md" },
    { text = "LuaCustRecyclerAdapter", file = "LuaCustRecyclerAdapter.md" },
    { text = "LuaFragment", file = "LuaFragment.md" },
    { text = "LuaFragmentAdapter", file = "LuaFragmentAdapter.md" },
    { text = "LuaPreferenceFragment", file = "LuaPreferenceFragment.md" },
    { text = "LuaRecyclerAdapter", file = "LuaRecyclerAdapter.md" },
    { text = "lazy", file = "lazy.md" },
    { text = "xTask", file = "xTask.md" },
    { text = "Coil", file = "Coil.md" },
    { text = "res", file = "module_res.md" },
    { text = "okhttp", file = "module_okhttp.md" },
    { text = "loadlayout", file = "module_loadlayout.md" },
    { text = "file", file = "module_file.md" },
    { text = "FileObserver", file = "other_FileObserver.md" },
    { text = res.string.global, file = "global_env.md" },
}

local adp = LuaAdapter(activity, data, item)
lv.setAdapter(adp)

lv.onItemClick = function(l, v, p, i)
    activity.setTitle(data[i].text)
    vpg.setCurrentItem(1)
    local md = LuaFileUtil.read(activity.getLuaDir() .. "/res/doc/" .. data[i].file)
    webView.loadFromText(md)
end

if bindClass "android.os.Build".VERSION.SDK_INT >= 33 then
    this.addOnBackPressedCallback(function()
            if vpg.getCurrentItem() ~= 0 then
                vpg.setCurrentItem(0)
                activity.setTitle("NeLuaJ+" .. res.string.help)
            else
                activity.finish()
            end
        end)
else
    function onKeyDown(code, event)
        if code == KeyEvent.KEYCODE_BACK then
            if vpg.getCurrentItem() ~= 0 then
                vpg.setCurrentItem(0)
                activity.setTitle("NeLuaJ+" .. res.string.help)
                return true
            else
                activity.finish()
            end
        end
    end
end
