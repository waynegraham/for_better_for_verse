<?php if (have_posts()) : while (have_posts()) : the_post(); ?>
	<h2><?php the_title(); ?></h2>
	<div class="entry">
		<?php the_content(); ?>			
	</div>
<?php endwhile; endif; ?>