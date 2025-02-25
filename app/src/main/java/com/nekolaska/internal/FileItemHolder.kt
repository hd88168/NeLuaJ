package com.nekolaska.internal

import android.view.View
import com.nekolaska.ktx.toLuaValue
import github.znzsofficial.adapter.LuaCustRecyclerHolder
import github.znzsofficial.neluaj.R
import org.luaj.LuaTable

class FileItemHolder(itemView: View) : LuaCustRecyclerHolder(itemView) {
    val Tag = LuaTable()
    fun bind(): LuaTable {
        return Tag.apply {
            set("contents", itemView.findViewById<View>(R.id.item_contents).toLuaValue())
            set("name", itemView.findViewById<View>(R.id.item_name).toLuaValue())
        }
    }

    fun unbind() {
        Tag.clear()
    }
}