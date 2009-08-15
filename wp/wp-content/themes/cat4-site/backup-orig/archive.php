<?php get_header(); ?>

	<div id="content">
	<?php is_tag(); ?>
	<?php if (have_posts()) : ?>

 	  <?php $post = $posts[0]; ?>
 	  <?php /* If this is a category archive */ if (is_category()) { ?>
		<h2>All Materials: <?php single_cat_title(); ?></h2>
 	  <?php /* If this is a tag archive */ } elseif( is_tag() ) { ?>
		<h2>Related Poem</h2>
 	  <?php /* If this is a daily archive */ } elseif (is_day()) { ?>
		<h2>Archive for <?php the_time('F jS, Y'); ?></h2>
 	  <?php /* If this is a monthly archive */ } elseif (is_month()) { ?>
		<h2>Archive for <?php the_time('F, Y'); ?></h2>
 	  <?php /* If this is a yearly archive */ } elseif (is_year()) { ?>
		<h2>Archive for <?php the_time('Y'); ?></h2>
	  <?php /* If this is an author archive */ } elseif (is_author()) { ?>
		<h2>Author Archives</h2>
 	  <?php /* If this is a paged archive */ } elseif (isset($_GET['paged']) && !empty($_GET['paged'])) { ?>
		<h2>Archives</h2>
 	  <?php } ?>

		<?php $posts = query_posts($query_string.'&orderby=title&order=asc'); ?>
		<?php while (have_posts()) : the_post(); ?>
		<?php include (TEMPLATEPATH . "/loop.php"); ?>
		<?php endwhile; ?>

		<div class="clearfloat pagination">
			<div class="left"><?php next_posts_link('&laquo; More') ?></div>
			<div class="right"><?php previous_posts_link('Back &raquo;') ?></div>
		</div>

	<?php else : ?>

		<h3>Not Found</h3>

	<?php endif; ?>

	</div>

<?php get_sidebar(); ?>

<?php get_footer(); ?>
