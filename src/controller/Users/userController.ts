import { prisma } from "../../utils/prisma";

export class userController {
  async store(req: any, res: any) {
    try {
      const { telegram_id, nome } = req.body;

      const user = await prisma.user.create({
        data: {
          nome,
          telegram_id,
        },
      });
      res.status(201).json(user);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Internal server error!" }, error);
    }
  }
}
