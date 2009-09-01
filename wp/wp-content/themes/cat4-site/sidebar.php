<div id="sidebar">
	
	<h3>List of Poems</h3>
<div id="poem_sorting">
	<h4 class="poem-sort-method">By Title</h4>
	<div class="poem-results">
		<ul class="titles">
		<?php query_posts('cat=3&orderby=title&order=asc&showposts=-1'); ?>
		 <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
		 <li><a href="<?php the_permalink() ?>" rel="bookmark"><?php the_title(); ?></a></li>
		 <?php endwhile; endif; ?>
		<?php query_posts(''); ?>
		</ul>
	</div>
	<h4 class="poem-sort-method">By Difficulty</h4>
	<div class="poem-results">
		<ul>
<?php $difficulty_categories = get_categories('child_of=11&orderby=ID&order=asc&showposts=-1'); ?>
<?php foreach ($difficulty_categories as $cat) : ?>
	
	<li><?php echo $cat->cat_name; ?>
	<?php $posts = get_posts('cat='.$cat->cat_ID.'&orderby=title&order=asc&showposts=-1'); ?>
	<?php if( $posts ) : ?>
	<ul class="titles">
	<?php foreach( $posts as $post ) : setup_postdata( $post ); ?>
	<li><a href="<?php the_permalink() ?>" rel="bookmark"><?php the_title(); ?></a></li>
	<?php endforeach; ?>
	</ul>
	</li>
	<?php endif; ?>

<?php endforeach; ?>
		</ul>
	</div>
	<h4 class="poem-sort-method">By Type</h4>
	<div class="poem-results">
		<ul>
<?php $type_categories = get_categories('child_of=12&orderby=name&order=asc'); ?>
<?php foreach ($type_categories as $cat) : ?>
	
	<li><?php echo $cat->cat_name; ?>
	<?php $posts = get_posts('cat='.$cat->cat_ID.'&orderby=title&order=asc'); ?>
	<?php if( $posts ) : ?>
	<ul class="titles">
	<?php foreach( $posts as $post ) : setup_postdata( $post ); ?>
	<li><a href="<?php the_permalink() ?>" rel="bookmark"><?php the_title(); ?></a></li>
	<?php endforeach; ?>
	</ul>
	</li>
	<?php endif; ?>

<?php endforeach; ?>

		</ul>
	</div>
</div>
	
	<?php if ( !function_exists('dynamic_sidebar') || !dynamic_sidebar() ) : endif; ?>
</div>

