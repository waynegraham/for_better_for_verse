<?php get_header(); ?>

<div id="content">

	<?php if (have_posts()) : ?>

		<h2>Search Results: "<?php the_search_query(); ?>"</h2>
		<?php include (TEMPLATEPATH . '/searchform.php'); ?>
		
		<?php query_posts($query_string . "&orderby=title&order=asc"); ?>
		<div id="results">
		<?php while (have_posts()) : the_post(); ?>

			<?php include (TEMPLATEPATH . "/loop.php"); ?>
		
		<?php endwhile; ?>
		</div>
		<div class="clearfloat pagination">
			<div class="left"><?php next_posts_link('&laquo; More') ?></div>
			<div class="right"><?php previous_posts_link('Back &raquo;') ?></div>
		</div>

	<?php else : ?>

		<h2>No matches found for "<?php the_search_query(); ?>".</h2>
		<p>Try a different search?</p>
		<?php include (TEMPLATEPATH . '/searchform.php'); ?>

	<?php endif; ?>

</div>

<?php get_sidebar(); ?>

<?php get_footer(); ?>
