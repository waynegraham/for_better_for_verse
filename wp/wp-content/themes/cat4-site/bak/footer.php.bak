</div><!--/wrapper-->

</div><!--/main-->


<div id="footer">

	<div class="wrapper vcard">
	
	<?php $temp_query = $wp_query; ?>
	<?php query_posts('showposts=1&pagename=Contact'); ?>
	 <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
		 <?php the_content(); ?>
	 <?php endwhile; endif; ?>
	<?php $wp_query = $temp_query; ?>
	
	</div>

</div><!--/footer-->


<?php wp_footer(); ?>
</body>
</html>