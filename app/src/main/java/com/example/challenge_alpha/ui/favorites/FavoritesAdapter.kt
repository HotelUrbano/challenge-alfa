package com.example.challenge_alpha.ui.favorites

import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.challenge_alpha.db.ResultDetailRelation
import com.example.challenge_alpha.model.ResultDetail

class FavoritesAdapter : ListAdapter<ResultDetailRelation, RecyclerView.ViewHolder>(REPO_COMPARATOR) {


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return FavoritesViewHolder.create(parent)
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        val repoItem = getItem(position)
        if (repoItem != null) {
            (holder as FavoritesViewHolder).bind(repoItem)
        }
    }

    override fun getItemViewType(position: Int): Int {

        return super.getItemViewType(position)
    }

    companion object {
        private val REPO_COMPARATOR = object : DiffUtil.ItemCallback<ResultDetailRelation>() {
            override fun areItemsTheSame(oldItem: ResultDetailRelation, newItem: ResultDetailRelation): Boolean =
                oldItem.resultDetail?.sku == newItem.resultDetail?.sku

            override fun areContentsTheSame(oldItem: ResultDetailRelation, newItem: ResultDetailRelation): Boolean =
                oldItem.resultDetail == newItem.resultDetail
        }
    }


}