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
<?php $type_categories = get_categories('child_of=12&orderby=name&order=asc&showposts=-1'); ?>
<?php foreach ($type_categories as $cat) : ?>
	
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
	<h4 class="poem-sort-method">By Author</h4>
	<div class="poem-results">
		<ul>
<?php
$args = array(
	'cat' => 3,
	'meta_key' => 'Author',
	'orderby' => 'meta_value',
	'order' => 'ASC',
	'showposts' => -1
); 
$authors = get_posts($args);
$previous_author = '';
	foreach ($authors as $post) :
		setup_postdata($post); 
		$author = get_post_meta($post->ID, 'Author', TRUE);
		if($author != $previous_author) :
			if($ul_open == true) : ?>
				</ul>
			<?php endif; ?>
			<li><?php echo $author; ?>
				<ul class="titles">
				<?php $ul_open = true; ?>
			<?php $loopargs = array(
				'cat' => 3,
				'meta_key' => 'Author',
				'meta_value' => $author,
				'orderby' => 'title',
				'order' => 'ASC',
				'showposts' => -1
			); ?>
			<?php $author_posts = get_posts($loopargs); ?>
			<?php foreach ($author_posts as $post) : ?>
			<li><a href="<?php the_permalink() ?>" rel="bookmark"><?php the_title(); ?></a></li>
			<?php endforeach; ?>
		<?php endif; ?>		
					
		<?php $previous_author = $author; ?>		
		 
<?php endforeach; ?>
<?php if($ul_open == true) : ?>
				</ul>
			</li>
<?php endif; ?>
		</ul>
	</div>
</div>
	
	<?php if ( !function_exists('dynamic_sidebar') || !dynamic_sidebar() ) : endif; ?>
</div>

